# Docker HomeLab Boilerplates

Contains docker compose YAML configurations for some of the most popular docker containers, along with bash scripts created by me for easily deploying the containers.

The boilerplates list is not exhaustive by any means, but for a beginner homelaber it covers mostly all the popular docker containers like Radarr and Sonarr to download movies and shows and Jellyfin to stream them from anywhere anytime.

![Screenshot (6)](https://user-images.githubusercontent.com/101431112/193395772-fa724e23-c278-4231-921f-7e3fb333f708.png)
![Screenshot (9)](./Images/Screenshot%20(1).png)
![Screenshot (8)](./Images/Screenshot%20(2).png)

## Usage
Make sure your server is updated
```bash
sudo apt update && sudo apt upgrade -y && sudo reboot
```

Clone the repo
```bash
git clone https://github.com/rishavnandi/Boiler_Plates && cd Boiler_Plates/Automated_Deployment
```

Make the scripts executable
```bash
sudo chmod +x Install_Docker.sh Create_Folder_Structure.sh Deploy_All_Containers.sh
```

Install Docker
```bash
sudo ./Install_Docker.sh
```

Reboot or logout so user can be added to Docker group
```bash
sudo reboot
```

Run the script to create all docker compose files
```bash
cd Boiler_Plates/Automated_Deployment && sudo ./Create_Folder_Structure.sh
```

Finally deploy all containers
```bash
./Deploy_All_Containers.sh
```

## Important!

Now you can navigate to ```<your_IP>:81``` to get to nginx proxy manager and you can start setting your domains up.

To check the id values for your system simply type "id" without the quotation marks in your terminal and you will see the gid and uid values for your system.

