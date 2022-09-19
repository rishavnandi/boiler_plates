# Docker HomeLab Boilerplates

Contains docker compose YAML configurations for some of the most popular docker containers, along with bash scripts created by me for easily deploying the containers.

The boilerplates list is not exhaustive by any means, but for a beginner homelaber it covers mostly all the popular docker containers like Radarr and Sonarr to download movies and shows and Jellyfin to stream them from anywhere anytime.

![Screenshot (10)](https://user-images.githubusercontent.com/101431112/191025194-9d4ff330-5e5b-4c64-8e80-9abf462a6c5a.png)
![Screenshot (9)](https://user-images.githubusercontent.com/101431112/191025221-8f007869-332a-4681-a574-400a334ad593.png)
![Screenshot (8)](https://user-images.githubusercontent.com/101431112/191025223-6159b505-b213-4c02-b07c-66ee964b1c7d.png)

## Usage
<ul>
    <li>Clone the repository</li>
    <li>Navigate to Automated_Deployment directory</li>
    <li>Run Install_Docker.sh</li>
    <li>Run Create_Folder_Structure.sh</li>
    <li>Replace the <PGID> and <PUID> placeholders with appropriate values for your system</li>
    <li>Replace the <Enter URL> placeholders with appropriate values for your system</li>
    <li>Run Deploy_All_Containers.sh</li>
</ul>

## Important!

I have left placeholders for the PGID and PUID parameters and the URL parameters in the "Create_Folder_Structure.sh" file, so anyone can replace them with the required values easily. Remember to replace them according to your system configuration.

To check the id values for your system simply type "id" without the quotation marks in your terminal and you will see the gid and uid values for your system.

In the <Enter URL> placeholders for wireguard and jellyfin you can simply add your servers IP address in that place.
