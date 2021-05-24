library IEEE;
use IEEE.std_logic_1164.all;

entity bcdcounter is
  port (
    clk, reset: in std_logic;
    digit     : out std_logic_vector(6 downto 0)
  );
end bcdcounter;

architecture rtl of bcdcounter is
begin
  process (clk, reset)
    variable temp : integer range 0 to 10;
  begin
    -- counter
    if (reset = '1') then
      temp := 0;
    elsif (rising_edge(clk)) then
      temp := temp + 1;
      if (temp = 10) then
        temp := 0;
      end if;
    end if;
    -- BCD->SSD conversion
    case temp is
      when 0 => digit <= "1111110"; -- 7E
      when 1 => digit <= "0110000"; -- 30
      when 2 => digit <= "1101101"; -- 6D
      when 3 => digit <= "1111001"; -- 79
      when 4 => digit <= "0110011"; -- 33
      when 5 => digit <= "1011011"; -- 5B
      when 6 => digit <= "1011111"; -- 5F
      when 7 => digit <= "1110000"; -- 70
      when 8 => digit <= "1111111"; -- 7F
      when 9 => digit <= "1111011"; -- 7B
      when others => NULL;
    end case;
  end process;
end rtl;
