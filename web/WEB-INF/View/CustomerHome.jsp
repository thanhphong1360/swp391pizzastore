<!-- FILE: customer_home.html -->
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Pizza House - Home</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background-color: #fff8f3;
    }
    .navbar-brand span {
      color: #e63946;
      font-weight: 700;
    }
    .hero {
      background: url('https://images.unsplash.com/photo-1601924582971-b0d29f3b39d9') center/cover no-repeat;
      height: 80vh;
      color: white;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      text-align: center;
    }
    .hero h1 {
      font-size: 3rem;
      font-weight: 700;
      text-shadow: 0 2px 6px rgba(0,0,0,0.4);
    }
    .menu-section {
      padding: 60px 0;
    }
    .menu-card {
      transition: transform 0.2s ease-in-out;
    }
    .menu-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    footer {
      background-color: #222;
      color: #ddd;
      padding: 40px 0;
    }
    footer a { color: #e63946; text-decoration: none; }
  </style>
</head>
<body>
  <!-- Navbar -->
  <nav class="navbar navbar-expand-lg navbar-light bg-light py-3 shadow-sm">
    <div class="container">
      <a class="navbar-brand" href="#"><span>Pizza</span>House</a>
      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ms-auto">
          <li class="nav-item"><a class="nav-link active" href="#">Home</a></li>
          <li class="nav-item"><a class="nav-link" href="#menu">Menu</a></li>
             <form action="${pageContext.request.contextPath}/Logout" method="post">
            <button class="logout-btn">Logout</button>
        </form>
          
        </ul>
      </div>
    </div>
  </nav>

  <!-- Hero Section -->
  <section class="hero">
    <h1>Welcome to Pizza House</h1>
    <p>Freshly baked. Perfectly crafted. Delivered hot.</p>
    <a href="#menu" class="btn btn-danger btn-lg mt-3">Order Now</a>
  </section>

  <!-- Menu Section -->
  <section id="menu" class="menu-section container">
    <h2 class="text-center mb-5 fw-bold">Our Menu</h2>
    <div class="row g-4">
      <div class="col-md-4">
        <div class="card menu-card">
          <img src="https://images.unsplash.com/photo-1601924582971-b0d29f3b39d9" class="card-img-top" alt="Pizza">
          <div class="card-body text-center">
            <h5 class="card-title">Margherita Pizza</h5>
            <p class="card-text text-muted">Classic tomato sauce, mozzarella & basil</p>
            <p class="fw-bold">$8.99</p>
            <button class="btn btn-sm btn-danger">Add to Cart</button>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card menu-card">
          <img src="https://images.unsplash.com/photo-1600891964599-f61ba0e24092" class="card-img-top" alt="Pizza">
          <div class="card-body text-center">
            <h5 class="card-title">Pepperoni Pizza</h5>
            <p class="card-text text-muted">Loaded with spicy pepperoni & cheese</p>
            <p class="fw-bold">$10.50</p>
            <button class="btn btn-sm btn-danger">Add to Cart</button>
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card menu-card">
          <img src="https://images.unsplash.com/photo-1627308595229-7830a5c91f9f" class="card-img-top" alt="Pizza">
          <div class="card-body text-center">
            <h5 class="card-title">Veggie Delight</h5>
            <p class="card-text text-muted">Bell peppers, onions, olives, mushrooms</p>
            <p class="fw-bold">$9.75</p>
            <button class="btn btn-sm btn-danger">Add to Cart</button>
          </div>
        </div>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="text-center">
    <div class="container">
      <p>© 2025 Pizza House. All rights reserved.</p>
      <p>Follow us on <a href="#">Facebook</a> | <a href="#">Instagram</a></p>
    </div>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
