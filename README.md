# CherryCRM

A clean, custom-designed WooCommerce CRM prototype built with **React + Node.js/Express + MySQL**. The interface follows the supplied CherryCRM reference: Times New Roman typography, Cherry `#670626`, and Warm Ivory `#F7F1EA`, with restrained borders, tables, whitespace and no generic admin-dashboard template.

The supplied reference UI is kept at `reference-ui.html` for comparison.

## Included features

- Dashboard with customers, orders, revenue, pending orders and recent orders
- Customer management: search, filters, add customer, customer profile
- Customer order history, tags, notes and communication actions
- Order management with search/filtering
- Order detail and status timeline
- Communication workflows with enable/disable controls
- Message templates with editable subject/body and variables
- WooCommerce sync screen with server-side mock sync flow
- Analytics with revenue, order and customer distribution views
- Customer insights/recommendations
- Settings page
- MySQL schema + seed data
- REST API using Express
- CORS and `.env` configuration

## Requirements

- Node.js 18+
- MySQL 8+

## Setup

### 1. Create the database

Open MySQL Workbench or the MySQL CLI and run:

`server/src/db/schema.sql`

This creates the `cherrycrm` database, tables and demo data.

### 2. Configure backend

Copy:

`server/.env.example` → `server/.env`

Then set your MySQL username/password.

Example:

```env
PORT=8080
CLIENT_URL=http://localhost:5173
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_NAME=cherrycrm
```

### 3. Install packages

From the CherryCRM root:

```bash
npm install
npm run install:all
```

### 4. Start both applications

```bash
npm run dev
```

Frontend: http://localhost:5173  
Backend: http://localhost:8080/api/health

## Run separately

Backend:

```bash
npm run server
```

Frontend:

```bash
npm run client
```

## API overview

- `GET /api/health`
- `GET /api/dashboard/summary`
- `GET /api/customers`
- `GET /api/customers/:id`
- `POST /api/customers`
- `POST /api/customers/:id/notes`
- `POST /api/customers/:id/send`
- `GET /api/orders`
- `GET /api/orders/:id`
- `PATCH /api/orders/:id/status`
- `GET /api/workflows`
- `PATCH /api/workflows/:id/toggle`
- `GET /api/workflows/templates`
- `PATCH /api/workflows/templates/:id`
- `GET /api/sync/last`
- `POST /api/sync`
- `GET /api/analytics`

## WooCommerce integration note

The current sync endpoint is deliberately a safe demo/simulation. It does not contain WooCommerce credentials. For a real store, connect WooCommerce from the Node.js server using environment variables and the WooCommerce REST API; never put API keys in React/browser code.

## Suggested next upgrades

1. Real WooCommerce REST API integration
2. Login/JWT authentication and role-based access
3. Real email provider integration
4. Product management and inventory
5. Persistent workflow event processing
6. Pagination and server-side search
7. Audit logs

## Design rules

Primary Cherry: `#670626`  
Warm Ivory: `#F7F1EA`  
Typography: Times New Roman  

The UI intentionally avoids excessive gradients, glassmorphism, giant rounded cards, neon colors and generic SaaS/AI dashboard styling.
