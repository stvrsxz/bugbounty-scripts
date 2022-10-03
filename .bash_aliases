inter_e(){
    interlace -t $1 -threads 40 -cL ~/bugbounty-scripts/intelace_scripts/endpoint.txt -o $2 -v --proto http,https
}

inter_d(){
    interlace -t $1 -threads 40 -cL ~/bugbounty-scripts/intelace_scripts/domain.txt -o $2 -v
}

inter_w(){
    interlace -t $1 -threads 40 -cL ~/bugbounty-scripts/intelace_scripts/wildcard.txt -o $2 -v
}

inter_i(){
    interlace -t $1 -threads 40 -cL ~/bugbounty-scripts/intelace_scripts/ip.txt -o $2 -v
}
