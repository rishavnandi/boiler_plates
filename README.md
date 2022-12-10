# Docker HomeLab Boilerplates

Contains docker compose YAML configurations for some of the most popular docker containers, along with bash scripts created by me for easily deploying the containers.

The boilerplates list is not exhaustive by any means, but for a beginner homelaber it covers mostly all the popular docker containers like Radarr and Sonarr to download movies and shows and Jellyfin to stream them from anywhere anytime.

- ## [Usage](https://github.com/rishavnandi/Boiler_Plates#usage-1)
- ## [Important Notes](https://github.com/rishavnandi/Boiler_Plates#important)

![Screenshot (6)](https://user-images.githubusercontent.com/101431112/193395772-fa724e23-c278-4231-921f-7e3fb333f708.png)
![Screenshot (1)](https://user-images.githubusercontent.com/92152818/195198940-3e5711de-f9b4-40ba-af87-ab1846f2038a.png)
![Screenshot (2)](https://user-images.githubusercontent.com/92152818/195198972-e8a78298-12da-4e42-97ed-c295f92e3547.png)


## Usage
Make sure your server is updated
```bash
sudo apt update && sudo apt upgrade -y && sudo reboot
```

Clone the repo
```bash
git clone https://github.com/rishavnandi/boiler_plates && cd boiler_plates/Automated_Deployment
```

Make the scripts executable
```bash
sudo chmod +x install_docker.sh create_folder_structure.sh deploy_all_containers.sh
```

Install Docker
```bash
sudo ./install_docker.sh
```

Reboot or logout so user can be added to Docker group
```bash
sudo reboot
```

Run the script to create all docker compose files
```bash
cd boiler_plates/automated_deployment && sudo ./create_folder_structure.sh
```

Finally deploy all containers
```bash
./deploy_all_containers.sh
```

## Important!

Now you can navigate to ```<your_IP>:81``` to get to nginx proxy manager and you can start setting your domains up.

To check the id values for your system simply type "id" without the quotation marks in your terminal and you will see the gid and uid values for your system.
