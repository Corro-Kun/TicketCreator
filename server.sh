#!/bin/bash

install_deps() {
    if [[ $1 == "all" || $1 == "f" ]]; then
        echo "Instalando dependencias para el Frontend..."
        (cd ./Frontend && npm install)
    fi

    if [[ $1 == "all" || $1 == "b" ]]; then
        echo "Instalando dependencias para el Backend..."
        (cd ./Backend && npm install)
    fi
}

run_servers() {
    if [[ $1 == "all" || $1 == "f" ]]; then
        echo "Corriendo servidor de Frontend..."
        (cd ./Frontend && npm start) &
    fi

    if [[ $1 == "all" || $1 == "b" ]]; then
        echo "Corriendo servidor de Backend..."
        (cd ./Backend && npm start) &
    fi

    # Espera a que ambos procesos terminen
    wait
}

build_projects() {
    if [[ $1 == "all" || $1 == "f" ]]; then
        echo "Construyendo proyecto Frontend..."
        (cd ./Frontend && npm run build)
    fi

    if [[ $1 == "all" || $1 == "b" ]]; then
        echo "Construyendo proyecto Backend..."
        (cd ./Backend && npm run build)
    fi
}

case "$1 $2" in
    "i all") install_deps "all" ;;
    "i f") install_deps "f" ;;
    "i b") install_deps "b" ;;
    "run all") run_servers "all" ;;
    "run f") run_servers "f" ;;
    "run b") run_servers "b" ;;
    "build all") build_projects "all" ;;
    "build f") build_projects "f" ;;
    "build b") build_projects "b" ;;
    *) echo "Uso: $0 {i|run|build} {all|f|b}" ;;
esac
