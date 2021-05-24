library IEEE;
use IEEE.std_logic_1164.all;

entity dreg_tb is
end dreg_tb;

architecture tb_arch of dreg_tb is
  --
  -- Component declaration of the DUT
  component dreg
    port (
      clk : in std_logic;
      rst : in std_logic;
      en  : in std_logic;
      d   : in std_logic;
      q   : out std_logic
    );
  end component;
  --
  -- Signal declarations
  signal clk : std_logic;
  signal rst : std_logic;
  signal en  : std_logic;
  signal d   : std_logic;
  signal q   : std_logic;
  --
  -- Constant declarations
  constant CLK_PERIOD : time := 50 ns;
begin

  -- Unit Under Test port map
  UUT : dreg
    port map (
      clk  => clk,
      rst  => rst,
      en   => en,
      d    => d,
      q    => q
    );

  CLK_GEN_PROC: process(clk)
  begin
    if (clk = 'U') then
      clk <= '1';
    else
      clk <= not clk after CLK_PERIOD/2;
    end if;
  end process CLK_GEN_PROC;

  DATA_STIM: process
  begin
    d <= '0'; en <= '0'; rst <= '1';
    wait for CLK_PERIOD;
    --
    d <= '1'; en <= '1'; rst <= '0';
    wait for CLK_PERIOD;
    --
    d <= '1';
    wait for 3*CLK_PERIOD;
    --
    d <= '0';
    wait for 2*CLK_PERIOD;
  end process DATA_STIM;

end tb_arch;
