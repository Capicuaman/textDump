 I'll provide two methods: the simple way (recommended to start) and a more advanced way using Docker Compose.

  Method 1: Add a Container in Portainer (Recommended)

  This is the most straightforward way to get Open WebUI running.

   1. Log in to Portainer.
   2. From the left menu, select Containers and then click the + Add container button.
   3. Fill out the form with the following details:
       * Name: open-webui
       * Image: ghcr.io/open-webui/open-webui:main
   4. Publish network ports:
       * Scroll down to the "Network ports configuration" section and click + publish a new network port.
       * Set host port to 3000
       * Set container port to 8080
   5. Set up the volume:
       * Scroll down to the "Advanced container settings" section at the bottom and click on the Volumes tab.
       * Click + map additional volume.
       * In the container field, enter /app/backend/data.
       * Leave the host/volume field as it is (it should say "Create a new volume" or similar). Portainer will 
         automatically create a named volume for you, which is what you want.
   6. Deploy the container:
       * Click the Deploy the container button.

  Once deployed, you can access Open WebUI in your browser at http://<your-server-ip>:3000.

  ---

  Method 2: Use a Docker Compose Stack in Portainer

  This method is better if you plan to run Open WebUI with other services, like Ollama, in a coordinated way.

   1. Log in to Portainer.
   2. From the left menu, select Stacks and then click the + Add stack button.
   3. Give the stack a name, like open-webui-stack.
   4. In the Web editor, paste the following code:

```yaml
services:
  open-webui:
    image: ghcr.io/open-webui/open-webui:main
    container_name: open-webui
    ports:
      - "3000:8080"
    volumes:
      - open-webui:/app/backend/data
    restart: unless-stopped

volumes:
  open-webui: {}
```

   5. Deploy the stack:
       * Click the Deploy the stack button.

  This will create the same Open WebUI container as the first method.