library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom_sync_tb is
end rom_sync_tb;

architecture tb_arch of rom_sync_tb is
  component rom_sync
    port (
      clk  : in std_logic;
      re   : in std_logic;
      addr : in std_logic_vector(3 downto 0);
      data : out std_logic_vector(7 downto 0)
    );
  end component;
  --
  signal clk : std_logic;
  signal re  : std_logic;
  signal addr: std_logic_vector(3 downto 0);
  signal data: std_logic_vector(7 downto 0);
  --
  constant CLK_PERIOD : time := 50 ns;
  --
begin

  -- Unit Under Test port map
  rom_sync_uut : rom_sync
    port map (
      clk  => clk,
      re   => re,
      addr => addr,
      data => data
    );

  CLK_GEN_PROC: process(clk)
  begin
    if (clk = 'U') then
      clk <= '1';
    else
      clk <= not clk after CLK_PERIOD/2;
    end if;
  end process CLK_GEN_PROC;

  DATA_INPUT: process
  begin
    re <= '0';
    addr <= "0010";
    wait for CLK_PERIOD;
    re <= '1';
    addr <= "0010";
    wait for CLK_PERIOD;
    --
    re <= '1';
    for i in 0 to 15 loop
      addr <= std_logic_vector(to_unsigned(i,4));
      wait for CLK_PERIOD;
     end loop;
  end process DATA_INPUT;

end tb_arch;
