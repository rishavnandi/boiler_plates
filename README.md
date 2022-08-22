# Docker HomeLab Boilerplates

Contains docker compose YAML configurations for some of the most popular docker containers, along with bash scripts created by me for easily deploying the containers.

The boilerplates list is not exhaustive by any means, but for a beginner homelaber it covers mostly all the popular docker containers like Radarr and Sonarr to download movies and shows and Jellyfin to stream them from anywhere anytime.

## Usage

-> Clone the repository
-> Navigate to Automated_Deployment directory
-> Run Install_Docker.sh
-> Run Create_Folder_Structure.sh
-> Replace the <PGID> and <PUID> placeholders with appropriate values for your system
-> Replace the <Enter URL> placeholders with appropriate values for your system
-> Run Deploy_All_Containers.sh

## Important!

I have left placeholders for the PGID and PUID parameters and the URL parameters in the "Create_Folder_Structure.sh" file, so anyone can replace them with the required values easily. Remember to replace them according to your system configuration.

To check the id values for your system simply type "id" without the quotation marks and you will see the gid and uid values for your system.

In the <Enter URL> placeholders for wireguard and jellyfin you can simply add your servers IP address in that place.