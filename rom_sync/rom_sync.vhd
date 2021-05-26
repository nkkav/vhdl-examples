library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom_sync is
  port (
    clk  : in std_logic;
    re   : in std_logic;
    addr : in std_logic_vector(3 downto 0);
    data : out std_logic_vector(7 downto 0)
  );
end rom_sync;

architecture impl of rom_sync is
  type rom_type is array (0 to 15) of std_logic_vector(7 downto 0); 
  constant ROM : rom_type :=
  (X"01", X"02", X"04", X"08", X"10", X"20", X"40", X"80",
   X"01", X"03", X"07", X"0F", X"1F", X"3F", X"7F", X"FF");
begin
  process (clk)
  begin
    if (rising_edge(clk)) then
      if (re = '1') then
        data <= ROM(to_integer(unsigned(addr)));
      end if;
    end if;
  end process;
end impl;
