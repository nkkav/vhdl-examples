library IEEE;
use IEEE.std_logic_1164.all;

entity rca is
  generic (N: integer := 8);
  port (
    a, b : in  std_logic_vector(N-1 downto 0);
    cin  : in  std_logic;
    sum  : out std_logic_vector(N-1 downto 0);
    cout : out std_logic
  );
end rca;

architecture gatelevel of rca is
  signal c : std_logic_vector(N downto 0);
begin
  c(0) <= cin;
  G1: for m in 0 to N-1 generate
    sum(m) <= a(m) xor b(m) xor c(m);
    c(m+1) <= (a(m) and b(m)) or
              (b(m) and c(m)) or
              (a(m) and c(m));
  end generate G1;
  cout <= c(N);
end gatelevel;
