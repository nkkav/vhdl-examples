library IEEE;
use IEEE.std_logic_1164.all;

entity fsm3p_tb is
end fsm3p_tb;

architecture tb_arch of fsm3p_tb is
  --
  -- Component declaration of the DUT
  component fsm3p
    port (
      clk   : IN std_logic;
      reset : IN std_logic;
      x1    : IN std_logic;
      outp  : OUT std_logic
    );
  end component;
  --
  -- Signal declarations
  signal clk   : std_logic;
  signal reset : std_logic;
  signal x1    : std_logic;
  signal outp  : std_logic;
  --
  -- Constant declarations
  constant CLK_PERIOD : time := 50 ns;

begin

  -- Unit Under Test port map
  UUT : fsm3p
    port map (
      clk   => clk,
      reset => reset,
      x1    => x1,
      outp  => outp
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
    reset <= '1'; x1 <= '0';
    wait for CLK_PERIOD;
    --
    reset <= '0'; x1 <= '1';
    wait for CLK_PERIOD;
    --
    reset <= '0'; x1 <= '1';
    wait for CLK_PERIOD;
    --
    reset <= '0'; x1 <= '0';
    wait for CLK_PERIOD;
    --
    reset <= '0'; x1 <= '0';
    wait for CLK_PERIOD;
    --
    reset <= '0'; x1 <= '1';
    wait for CLK_PERIOD;
    --
    reset <= '1'; x1 <= '1';
    wait for CLK_PERIOD;
    --
    reset <= '0'; x1 <= '0';
    wait for CLK_PERIOD;
    --
    reset <= '0'; x1 <= '1';
    wait for CLK_PERIOD;
  end process DATA_STIM;

end tb_arch;
