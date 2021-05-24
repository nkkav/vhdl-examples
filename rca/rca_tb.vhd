library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

entity rca_tb is
  generic (N: INTEGER:= 8);
end rca_tb;

architecture tb_arch of rca_tb is
  -- Component declaration of the tested unit
  component rca
    generic (N: INTEGER:= 8);
    port (
      a    : in  std_logic_vector(N-1 downto 0);
      b    : in  std_logic_vector(N-1 downto 0);
      cin  : in  std_logic;
      sum  : out std_logic_vector(N-1 downto 0);
      cout : out std_logic
    );
  end component;
  -- Stimulus signals - signals mapped to the input and inout ports of tested entity
  signal a : std_logic_vector(N-1 downto 0);
  signal b : std_logic_vector(N-1 downto 0);
  signal cin : std_logic;
  -- Observed signals - signals mapped to the output ports of tested entity
  signal sum : std_logic_vector(N-1 downto 0);
  signal cout : std_logic;
  --
  file output_log  : text open write_mode is "rca.txt";
begin

  -- Unit Under Test port map
  UUT : rca
    generic map ( N => N )
    port map ( a => a, b => b, cin => cin, sum => sum, cout => cout );

  process
  begin
    a <= X"FF"; b <= X"10"; cin <= '0';
    wait for 10 ns;
    a <= X"10"; b <= X"89"; cin <= '1';
    wait for 10 ns;
    a <= X"E5"; b <= X"9A"; cin <= '0';
    wait for 10 ns;
    a <= X"FD"; b <= X"01"; cin <= '1';
    wait for 10 ns;
    a <= X"FE"; b <= X"07"; cin <= '0';
    wait for 10 ns;
  end process;

  output_log_proc: process
    variable out_line : line;
  begin
    write(out_line, NOW, left, 8);
    write(out_line, string'(" a:"), right, 4);
    hwrite(out_line, a, right, 4);
    write(out_line, string'(" b:"), right, 4);
    hwrite(out_line, b, right, 4);
    write(out_line, string'(" cin:"), right, 4);
    write(out_line, cin, right, 4);
    write(out_line, string'(" sum:"), right, 4);
    hwrite(out_line, sum, right, 4);
    write(out_line, string'(" cout:"), right, 4);
    write(out_line, cout, right, 4);
    writeline(output_log, out_line);
    wait for 10 ns;
  end process output_log_proc;

end tb_arch;
