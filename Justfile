set shell := ["powershell.exe", "-c"]

build-css:
    tailwindcss -i ./static/css/input.css -o ./static/css/output.css

run:
    cargo shuttle run

login:
    shuttle login

deploy: build-css
    shuttle deploy

start:
    shuttle project start