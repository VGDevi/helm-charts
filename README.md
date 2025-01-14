# Project Deployment Overview

This repository outlines the deployment of a full-stack application consisting of the frontend and backend services using Kubernetes. The application is deployed using a **single Docker image** for both services, following the guidelines from the Vikunja documentation.

## Key Design Decisions

### 1. **Single Docker Image for Frontend and Backend**
   - **Reasoning**: Based on the Vikunja documentation, the usage of a single Docker image for both frontend and backend is recommended, as separate images are deprecated.
   - **Benefits**:
     - Simplifies deployment and maintenance.
     - Ensures compatibility between frontend and backend.

### 2. **Database Deployment Strategy**
   - **Deployment Method**: The database is deployed using a **StatefulSet** to ensure each pod receives a unique, stable network identity and persistent storage.
   - **Persistent Volume Claim (PVC)**: Data is persisted using PVCs, ensuring data is maintained even during pod restarts.
   - **Justification**: StatefulSets are ideal for applications like databases where data consistency and persistence are crucial.

## Optional: Keycloak IAM Setup

when project involves user authentication and role-based access, **Keycloak** is integrated as the Identity and Access Management (IAM) solution. This provides:
   - **Secure access** to the application.
   - Simplified user authentication and authorization.
   - **Role-based access control (RBAC)**.

## Optimization Considerations

- **Helm Chart for Unified Deployment**: 
  - Using a single Helm chart for both services reduces complexity and ensures configuration consistency.
  
- **Persistent Storage with PVC**:
  - Ensures database data is not lost across pod restarts, maintaining high reliability.

- **StatefulSet for Database**:
  - The use of StatefulSets ensures that database pods maintain their unique identity and data integrity.

## Conclusion

The design prioritizes:
- **Simplicity**: The unified deployment strategy with a single Docker image and Helm chart reduces management overhead.
- **Reliability**: StatefulSets with PVCs ensure data persistence and fault tolerance for the database.

This setup is optimized for easy deployment and scalability in Kubernetes environments.

---
