library IEEE;
use IEEE.std_logic_1164.all;

entity tlc_tb is
end tlc_tb;

architecture tb_arch of tlc_tb is
  component tlc
    port (			  
      clk : in std_logic;
      reset : in std_logic;
      cars : in std_logic;
      short : in std_logic;
      long : in std_logic;
      highway_green : out std_logic;
      highway_yellow : out std_logic;
      highway_red : out std_logic;
      farm_green : out std_logic;
      farm_yellow : out std_logic;
      farm_red : out std_logic;
      start_timer : out std_logic
    );
  end component;
  -- 
  signal clk : std_logic;
  signal reset : std_logic;
  signal cars : std_logic;
  signal short : std_logic;
  signal long : std_logic;
  --
  signal highway_green : std_logic;
  signal highway_yellow : std_logic;
  signal highway_red : std_logic;
  signal farm_green : std_logic;
  signal farm_yellow : std_logic;
  signal farm_red : std_logic;
  signal start_timer : std_logic;
  --
  constant CLK_PERIOD : time := 50 ns;
  constant SHORT_INTERVAL : time := 3*CLK_PERIOD;
  constant LONG_INTERVAL : time := 10*CLK_PERIOD;
  --
begin

  uut : tlc
    port map (
      clk => clk,
      reset => reset,
      cars => cars,
      short => short,
      long => long,
      highway_green => highway_green,
      highway_yellow => highway_yellow,
      highway_red => highway_red,
      farm_green => farm_green,
      farm_yellow => farm_yellow,
      farm_red => farm_red,
      start_timer => start_timer
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
    variable ix : integer range 0 to 7;
  begin
    reset <= '0';
    cars <= '0';
    short <= '0';
    long <= '0';
    wait for CLK_PERIOD;
    --
    reset <= '1';
    wait for CLK_PERIOD;
    --
    reset <= '0';
    wait for SHORT_INTERVAL;
    --
    cars <= '0';
    long <= '1';
    wait for LONG_INTERVAL;
    cars <= '1';
    wait for CLK_PERIOD;
    wait for LONG_INTERVAL;
    cars <= '1';
    short <= '1';
    wait for SHORT_INTERVAL;
    cars <= '0';
    wait for LONG_INTERVAL;
    short <= '1';
    wait for SHORT_INTERVAL;
    short <= '0';
    wait for LONG_INTERVAL;
  end process DATA_INPUT;

end tb_arch;
