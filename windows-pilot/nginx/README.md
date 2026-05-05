# Nginx for Windows

Nginx for Windows is optional for this pilot. IIS is also acceptable for serving the static frontend and reverse proxying to the backend.

Use Nginx if you want one internal URL serving:

- The React frontend from `react_frontend/dist`
- `/api/` proxied to the backend on `127.0.0.1:3002`
- `/socket.io/` proxied to the backend with WebSocket upgrade headers

Copy the example config:

```powershell
copy kore.windows.nginx.conf.example C:\nginx\conf\conf.d\kore.conf
```

Test the config:

```powershell
C:\nginx\nginx.exe -t
```

Reload Nginx:

```powershell
C:\nginx\nginx.exe -s reload
```

The `/socket.io/` location must include WebSocket proxy headers or realtime events will fail.
