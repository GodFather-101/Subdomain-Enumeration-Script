#!/usr/bin/bash
echo "Enter Your url or domain here : "

read domain

echo "your domain is $domain"

#subfinder

echo "running subfinder.."

subfinder -d $domain -o ./subfinder-results/subfinder_$domain.txt

echo "output stored at subfinder-results/subfinder_$domain.txt"

#AMASS

echo "running amass enumeration for finding subdomains..."

amass enum -d $domain -o ./amass-results/amass_$domain.txt

echo "output results from amass are stored at /amass-results/amass_$domain.txt"

#Knockpy

echo "running knockpy for subdomain enumeration..."

python3 tools/knock/knockpy.py $domain -o knock-results

cd knock-results && mv $domain*.json $domain.json && cd ../

#mv knock-results/$domain*.json knock-results/$domain.json

echo "converting json to domain only file...."

#python3 tools/helper/json_filter.py $domain

python3 json_filter.py $domain

echo "conversion completed please check out at the knock-results folder \n for more details please check at the official json file."

python3 tools/helpers/json_filter.py $domain

echo "output stored on /tools/knock/knock-results/$domain.*.json"

#sublist3r

echo "Now running sublist3r for subdomain enumeration ..."

sublist3r -d $domain -b -v -t10 -o ./sublist3r-results/sublist3r_$domain.txt

echo "outputs are stored on sublist3r-results/sublist3r_$domain.txt"

#subBrute

echo "subBrute Tool for finding somemore subdomains..."

cd ./tools/subbrute/ && python3 subbrute.py $domain -o ../../subBrute-results/subbrute_$domain.txt

echo "The results are stored on subBrute-results/subbrute_$domain.txt"

echo "collecting Total subdomains collected from 5 such tools..."

cat ~/Tools/SubDomain_Enumeration/subdomainFinder/subfinder-results/subfinder_$domain.txt ~/Tools/SubDomain_Enumeration/subdomainFinder/amass-results/amass_$domain.txt  ~/Tools/SubDomain_Enumeration/subdomainFinder/knock-results/$domain.txt ~/Tools/SubDomain_Enumeration/subdomainFinder/sublist3r-results/sublist3r_$domain.txt ~/Tools/SubDomain_Enumeration/subdomainFinder/subBrute-results/subbrute_$domain.txt > dup_total-subdomains

echo "removing duplicates ...."

cat dup_total_$domain-subdomains | sort -u > Final-$domain-SubDomains.txt

#________________________________________________________________________________________________________________

echo "Subdomain enumeration completed.. Now it's the time for brute subdomains finding more sub-subdomains using altdns tool...:)"

#ALTdns

altdns -i Final-$domain-SubDomains.txt -o altDNS-Results/all_combinations-$domain -r -s Resolved_Outputs/$domain-resolved.txt





