library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ram_async_tb is
end ram_async_tb;

architecture tb_arch of ram_async_tb is
  component ram_async
    port (
      clk : in std_logic;
      we : in std_logic;
      rwaddr : in std_logic_vector(5 downto 0);
      di : in std_logic_vector(15 downto 0);
      do : out std_logic_vector(15 downto 0)
    );
  end component;
  --
  signal clk : std_logic;
  signal we  : std_logic;
  signal rwaddr : std_logic_vector(5 downto 0);
  signal di : std_logic_vector(15 downto 0);
  signal do : std_logic_vector(15 downto 0);
  --
  constant CLK_PERIOD : time := 50 ns;
  --
begin

  -- Unit Under Test port map
  ram_async_uut : ram_async
    port map (
      clk => clk,
      we => we,
      rwaddr => rwaddr,
      di => di,
      do => do
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
    we <= '0'; rwaddr <= "101010"; di <= X"CAFE";
    wait for CLK_PERIOD;
    we <= '1'; rwaddr <= "101010"; di <= X"CAFE";
    wait for CLK_PERIOD;
    we <= '0'; rwaddr <= "101010"; di <= X"CAFE";
    wait for CLK_PERIOD;
    we <= '0'; rwaddr <= "111010"; di <= X"DEED";
    wait for CLK_PERIOD;
    we <= '0'; rwaddr <= "111010"; di <= X"DEED";
    wait for 2*CLK_PERIOD;
  end process DATA_INPUT;

end tb_arch;
