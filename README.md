## **What Is This?** 
This repository contains `nav_rest_api_turtlebot` that runs a simulation of TurtleBot3 in `tb3_world` with its own navigational planning.

## **Build** :hammer:

```bash
git clone https://github.com/cardboardcode/nav_rest_api_turtlebot --depth 1 --branch feature/tb3_autodock --single-branch
```

```bash
docker build -t ros1_turtlebot3_rest_api .
```

## **Run** 

```bash
docker compose up
```
