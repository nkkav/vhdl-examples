library IEEE;
use IEEE.std_logic_1164.all;

entity fsm3p is
  port ( 
    clk   : IN std_logic;
    reset : IN std_logic;
    x1    : IN std_logic;
    outp  : OUT std_logic
  );
end fsm3p;

architecture beh1 of fsm3p is
  type state_type is (s1,s2,s3,s4);
  signal current_state, next_state: state_type;
begin
  process1: process (clk, reset)
  begin
  if (reset ='1') then
    current_state <= s1;
  elsif (rising_edge(clk)) then
    current_state <= next_state;
  end if;
  end process process1;

  process2 : process (current_state, x1)
  begin
  case current_state is
    when s1 => 
      if (x1 = '1') then
        next_state <= s2;
      else
        next_state <= s3;
      end if;
    when s2 => 
      next_state <= s4;
    when s3 => 
      next_state <= s4;
    when s4 => 
      next_state <= s1;
  end case; 
  end process process2;

  process3 : process (current_state)
  begin
  case current_state is
    when s1 => outp <= '1';
    when s2 => outp <= '1';
    when s3 => outp <= '0';
    when s4 => outp <= '0';
  end case;
  end process process3;
end beh1;
