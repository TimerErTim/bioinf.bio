// --- 1. CORE SPLINE SOLVER (from previous step) ---
// Solves for the "Moments" (2nd derivatives) at the knots
#let get-spline-moments(x, y) = {
  let n = x.len()
  let h = range(n - 1).map(i => x.at(i + 1) - x.at(i))
  let alpha = range(1, n - 1).map(i => 
    6 / h.at(i) * (y.at(i + 1) - y.at(i)) - 6 / h.at(i - 1) * (y.at(i) - y.at(i - 1))
  )
  
  // Tridiagonal Solver Logic (Thomas Algorithm)
  let b = range(1, n - 1).map(i => 2 * (h.at(i - 1) + h.at(i)))
  let c = range(0, n - 3).map(i => h.at(i + 1)) 
  let a = range(0, n - 3).map(i => h.at(i + 1)) 

  // (Simplified inline solver for brevity)
  let c_prime = (0.0,) * (n - 2)
  let d_prime = (0.0,) * (n - 2)
  c_prime.at(0) = c.at(0) / b.at(0)
  d_prime.at(0) = alpha.at(0) / b.at(0)
  
  for i in range(n - 3) {
    let temp = b.at(i) - a.at(i - 1) * c_prime.at(i - 1)
    c_prime.at(i) = c.at(i) / temp
    d_prime.at(i) = (alpha.at(i) - a.at(i - 1) * d_prime.at(i - 1)) / temp
  }
  
  let M_inner = (0.0,) * (n - 2)
  M_inner.at(n - 3) = d_prime.at(n - 3)
  let i = n - 4
  while i >= 0 {
    M_inner.at(i) = d_prime.at(i) - c_prime.at(i) * M_inner.at(i + 1)
    i = i - 1
  }
  return (0.0,) + M_inner + (0.0,) // Pad boundaries with 0
}

// --- 2. EVALUATOR ---
// Calculates y for any x using the Cubic Spline Interpolation Formula
#let eval-spline(target_x, x_data, y_data, M) = {
  // Find the interval [x_i, x_{i+1}] containing target_x
  let i = 0
  while i < x_data.len() - 2 and target_x > x_data.at(i + 1) {
    i = i + 1
  }
  
  let h = x_data.at(i + 1) - x_data.at(i)
  let A = (x_data.at(i + 1) - target_x) / h
  let B = (target_x - x_data.at(i)) / h
  
  // Standard Cubic Spline Formula
  let y_interp = (A * y_data.at(i) + B * y_data.at(i + 1) + 
                 ((calc.pow(A, 3) - A) * M.at(i) + (calc.pow(B, 3) - B) * M.at(i + 1)) * (h * h) / 6)
  return y_interp
}
