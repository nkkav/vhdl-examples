library ieee;
use ieee.std_logic_1164.all;

entity tlc is
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
end tlc;

architecture impl of tlc is
  type tlc_states is (HGO, HSTOP, FGO, FSTOP);
  signal current_state, next_state : tlc_states;
begin
  -- current state logic  
  process (clk) 
  begin
    if rising_edge(clk) then
      current_state <= next_state;
    end if;
  end process;

  -- next state and output logic combined  
  process (current_state, reset, cars, short, long)
  begin
  if (reset = '1') then
    start_timer <= '1'; 
    next_state <= HGO;
  else
    case current_state is
      when HGO =>
        highway_green <= '1'; highway_yellow <= '0'; highway_red <= '0';
        farm_green <= '0'; farm_yellow <= '0'; farm_red <= '1';
        if (cars = '1' and long = '1') then
          start_timer <= '1'; 
          next_state <= HSTOP;
        else 
          start_timer <= '0'; 
          next_state <= HGO;
        end if;
      when HSTOP =>
        highway_green <= '0'; highway_yellow <= '1'; highway_red <= '0';
        farm_green <= '0'; farm_yellow <= '0'; farm_red <= '1';
        if (short = '1') then
          start_timer <= '1'; 
          next_state <= FGO;
        else 
          start_timer <= '0'; 
          next_state <= HSTOP;
        end if;
      when FGO =>
        highway_green <= '0'; highway_yellow <= '0'; highway_red <= '1';
        farm_green <= '1'; farm_yellow <= '0'; farm_red <= '0';
        if (cars = '0' or long = '1') then
          start_timer <= '1'; 
          next_state <= FSTOP;
        else 
          start_timer <= '0'; 
          next_state <= FGO;
        end if;
      when FSTOP =>
        highway_green <= '0'; highway_yellow <= '0'; highway_red <= '1';
        farm_green <= '0'; farm_yellow <= '1'; farm_red <= '0';
        if (short = '1') then
          start_timer <= '1'; 
          next_state <= HGO;
        else 
          start_timer <= '0'; 
          next_state <= FSTOP;
        end if;
      end case;
    end if;
  end process;

end impl;
