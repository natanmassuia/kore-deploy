// Example only. Adjust paths and scripts for the target VM.
// Backend alternatives:
// - script: "npm", args: "run start"
// - script: "node", args: "dist/index.js"

module.exports = {
  apps: [
    {
      name: "kore-backend",
      cwd: "C:/Apps/kore-app/node_backend",
      script: "npm",
      args: "run start",
      env: {
        NODE_ENV: "production"
      }
    },
    {
      name: "kore-frontend",
      cwd: "C:/Apps/kore-app/react_frontend",
      script: "serve",
      args: "-s dist -l 5173",
      env: {
        NODE_ENV: "production"
      }
    }
  ]
};
