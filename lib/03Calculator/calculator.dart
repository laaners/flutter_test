int factorial(n) {
  if (n == 0) return 1;
  return n * factorial(n - 1);
}

int power(x, n) {
  if (n == 0) return 1;
  return x * power(x, n - 1);
}
