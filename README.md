# Client Finder API

This Rails application allows you to upload a list of clients with location data and filter them based on distance in kilometers.

## 📦 Features

- Filter clients based on geographical distance
- API endpoint to get clients within a specified range

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone git@github.com:idhruvnaik/client_finder.git
cd client_finder
```

### 2. Bundle Install
```bash
bundle install
```

### 3. Run test cases
```bash
RAIL_ENV=test bundle exec rspec
```

### 4. Start the server
```bash
rails server
```

### 5. Download the sample file for testing
```bash
https://assets.theinnerhour.com/take-home-test/customers.txt
```

### 6. API configuration
```bash
POST /client/finder/within_n_km
```

### 7. API Documentation path
```bash
documentation/api
```


> 👤 Dhruv Naik