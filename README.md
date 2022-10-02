# Docker HomeLab Boilerplates

Contains docker compose YAML configurations for some of the most popular docker containers, along with bash scripts created by me for easily deploying the containers.

The boilerplates list is not exhaustive by any means, but for a beginner homelaber it covers mostly all the popular docker containers like Radarr and Sonarr to download movies and shows and Jellyfin to stream them from anywhere anytime.

![Screenshot (6)](https://user-images.githubusercontent.com/101431112/193395772-fa724e23-c278-4231-921f-7e3fb333f708.png)
![Screenshot (9)](https://user-images.githubusercontent.com/101431112/191025221-8f007869-332a-4681-a574-400a334ad593.png)
![Screenshot (8)](https://user-images.githubusercontent.com/101431112/191025223-6159b505-b213-4c02-b07c-66ee964b1c7d.png)

## Usage
Make sure your server is updated
```shell
sudo apt update && sudo apt upgrade -y && sudo reboot
```

Clone the repo
```shell
git clone https://github.com/rishavnandi/Boiler_plates && cd Boiler_plates/Automated_Deployment
```

Make the scripts executable
```shell
sudo chmod +x Install_Docker.sh Create_Folder_Structure.sh Deploy_All_Containers.sh
```

Install Docker
```shell
sudo ./Install_Docker.sh
```

Reboot or logout so user can be added to Docker group
```shell
sudo reboot
```

Run the script to create all docker compose files
```shell
cd Boiler_plates/Automated_Deployment && sudo ./Create_Folder_Structure.sh
```

Finally deploy all containers
```shell
./Deploy_All_Containers.sh
```

## Important!

Now you can navigate to ```<your_IP>:81``` to get to nginx proxy manager and you can start setting your domains up.

To check the id values for your system simply type "id" without the quotation marks in your terminal and you will see the gid and uid values for your system.

