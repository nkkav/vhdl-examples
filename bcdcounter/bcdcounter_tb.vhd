library IEEE;
use IEEE.std_logic_1164.all;

entity bcdcounter_tb is
end bcdcounter_tb;

architecture tb_arch of bcdcounter_tb is
  --
  -- Component declaration of the DUT
  component bcdcounter
    port (
     clk   : in std_logic;
     reset : in std_logic;
     digit : out std_logic_vector(6 downto 0)
    );
  end component;
  --
  -- Signal declarations
  signal clk    : std_logic;
  signal reset  : std_logic;
  signal digit  : std_logic_vector(6 downto 0);
  --
  -- Constant declarations
  constant CLK_PERIOD : time := 50 ns;
begin

  -- Unit Under Test port map
  UUT : bcdcounter
    port map (
      clk => clk,
      reset => reset,
      digit => digit
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
    reset <= '1';
    wait for CLK_PERIOD;
    --
    reset <= '0';
    wait for 12*CLK_PERIOD;
  end process DATA_STIM;

end tb_arch;
