# TODO: alert on diff --> discord
import datetime
import os
import subprocess
from time import sleep

DATE = datetime.datetime.now().strftime("%Y-%m-%d_%H-%M")
ROOT_DIR = os.path.expanduser("linkfinder")
INPUT_URLS_PATH = f"{ROOT_DIR}/urls.txt"
CRAWLED_URLS_PATH = f"{ROOT_DIR}/crawled_urls_{DATE}.txt"


def initialize():
    subprocess.run(f"mkdir -p {ROOT_DIR}", shell=True)
    if not os.path.exists(INPUT_URLS_PATH):
        subprocess.run(f"touch {INPUT_URLS_PATH}", shell=True)


def get_urls():
    try:
        return open(os.path.expanduser(INPUT_URLS_PATH), "r").read().splitlines()
    except FileNotFoundError:
        exit(INPUT_URLS_PATH)


def crawl_urls():
    for url in get_urls():
        if url.startswith("#"):
            continue

        crawled_urls = subprocess.run(
            f"cat {INPUT_URLS_PATH} | hakrawler -timeout 5 | tee -a {CRAWLED_URLS_PATH}",
            shell=True,
            capture_output=True,
        )

        for crawled_url in crawled_urls.stdout.decode().splitlines():
            if ".js" not in crawled_url:
                continue

            if any(
                ignore in crawled_url
                for ignore in [
                    "jquery",
                    "google-analytics",
                    "gpt.js",
                    "modernizr",
                    "gtm",
                    "fbevents",
                ]
            ):
                continue

            print(f"Extracting paths for {crawled_url}")

            clean_url = (
                url.replace("http://", "")
                .replace("https://", "")
                .rstrip("/")
                .replace("/", "-")
            )

            sleep(1)

            paths = subprocess.run(
                f"~/recon/tools/LinkFinder/venv/bin/python3 ~/recon/tools/LinkFinder/linkfinder.py -i '{crawled_url}' -o cli | tee -a {ROOT_DIR}/{clean_url}_{DATE}.txt",
                shell=True,
                capture_output=True,
            )


initialize()
crawl_urls()
