library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram_sync is
  port (
    clk     : in  std_logic;
    we      : in  std_logic;
    rwaddr  : in  std_logic_vector(5 downto 0);
    di      : in  std_logic_vector(15 downto 0);
    do      : out std_logic_vector(15 downto 0)
  );
end ram_sync;

architecture synth of ram_sync is
  type ram_type is array (63 downto 0) of std_logic_vector(15 downto 0);
  signal RAM: ram_type;
begin
  process (clk)
  begin
    if (rising_edge(clk)) then
      if (we = '1') then
        RAM(to_integer(unsigned(rwaddr))) <= di;
      end if;
      do <= RAM(to_integer(unsigned(rwaddr)));
    end if;
  end process;
end synth;
