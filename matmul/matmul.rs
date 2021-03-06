use std::env;

fn newmat(x: usize, y: usize) -> Vec<Vec<f64>> {
  let mut r = Vec::new();
  for _ in 0..x {
    let mut c = Vec::new();
    for _ in 0..y { c.push(0_f64); }
    r.push(c);
  }
  r
}

fn matgen(n: usize) -> Vec<Vec<f64>> {
  let mut a = newmat(n, n);
  let tmp = 1_f64 / (n as f64) / (n as f64);
  for i in 0..n {
    for j in 0..n {
      let val = tmp * (i as f64 - j as f64) * (i as f64 + j as f64);
      *a.get_mut(i).unwrap().get_mut(j).unwrap() = val; // Wtf, rust O_o
    }
  }
  a
}

fn matmul(a: Vec<Vec<f64>>, b: Vec<Vec<f64>>) -> Vec<Vec<f64>> {
  let m = a.len();
  let n = a[0].len();
  let p = b[0].len();

  let mut b2 = newmat(n, p);
  for i in 0..n {
    for j in 0..p {
      *b2.get_mut(j).unwrap().get_mut(i).unwrap() = b[i][j];
    }
  }

  let mut c = newmat(m, p);
  for i in 0..m {
    for j in 0..p {
      let mut s = 0_f64;
      let ref ai = a[i];
      let ref b2j = b2[j];
      for k in 0..n {
        s += ai[k] * b2j[k];
      }
      *c.get_mut(i).unwrap().get_mut(j).unwrap() = s;
    }
  }

  c
}

fn main() {
  let mut n = 100;
  if env::args().len() > 1 { 
    let arg1 = env::args().nth(1).unwrap();
    n = ::std::str::FromStr::from_str(&arg1).unwrap(); 
  }
  n = n / 2 * 2;

  let a = matgen(n);
  let b = matgen(n);
  let c = matmul(a, b);
  print!("{}\n", c[n / 2][n / 2]);
}
