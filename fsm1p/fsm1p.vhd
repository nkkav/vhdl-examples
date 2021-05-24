library IEEE;
use IEEE.std_logic_1164.all;

entity fsm1p is
port (
  clk   : IN std_logic;
  reset : IN std_logic;
  x1    : IN std_logic;
  outp  : OUT std_logic
);
end fsm1p;

architecture beh1 of fsm1p is
  type state_type is (s1,s2,s3,s4);
  signal state: state_type;
begin
  process (clk, reset)
  begin
  if (reset ='1') then
    state <= s1;
    outp <= '1';
  elsif (rising_edge(clk)) then
    case state is
      when s1 => 
        if (x1 = '1') then
          state <= s2;
          outp <= '1';
        else
          state <= s3;
          outp <= '0';
        end if;
      when s2 => 
        state <= s4; 
        outp <= '0';
      when s3 => 
        state <= s4; 
        outp <= '0';
      when s4 => 
        state <= s1; 
        outp <= '1';
    end case;
  end if;
  end process;
end beh1;
