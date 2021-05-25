library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom_async_tb is
end rom_async_tb;

architecture tb_arch of rom_async_tb is
  component rom_async
    port (
      addr    : in std_logic_vector(3 downto 0);
      data    : out std_logic_vector(7 downto 0)
    );
  end component;
  --
  signal addr: std_logic_vector(3 downto 0);
  signal data: std_logic_vector(7 downto 0);
  --
  constant CLK_PERIOD : time := 50 ns;
  --
begin

  -- Unit Under Test port map
  rom_async_uut : rom_async
    port map (
      addr => addr,
      data => data
    );


  DATA_INPUT: process
  begin
    for i in 0 to 15 loop
      addr <= std_logic_vector(to_unsigned(i,4));
      wait for CLK_PERIOD;
    end loop;
  end process DATA_INPUT;

end tb_arch;
