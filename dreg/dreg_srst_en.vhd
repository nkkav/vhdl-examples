library IEEE;
use IEEE.std_logic_1164.all;

entity dreg is
  port (
    clk   : in std_logic;
    rst   : in std_logic;
    en    : in std_logic;
    d     : in std_logic;
    q     : out std_logic
  );
end dreg;

architecture rtl of dreg is
  signal temp : std_logic;
begin
  process (clk)
  begin
    if (rising_edge(clk)) then
      if (rst = '1') then
        temp <= '0';
      else
        if (en = '1') then
          temp <= d;
        end if;
      end if;
    end if;
  end process;

  q <= temp;

end rtl;
