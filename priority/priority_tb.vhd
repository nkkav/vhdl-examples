library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity priority_tb is
end priority_tb;

architecture tb_arch of priority_tb is
  component priority
    port (
      sel  : in  std_logic_vector(7 downto 0);
      code : out unsigned(2 downto 0)
    );
  end component;
  -- 
  signal sel  : std_logic_vector(7 downto 0);
  signal code : unsigned(2 downto 0);
  --
  constant PERIOD : time := 50 ns;
  --
begin

  -- Unit Under Test port map
  priority_uut : priority
    port map (
      sel => sel,
      code => code
    );

  DATA_INPUT: process
  begin
    sel <= "10101010";
    wait for PERIOD;
    sel <= "00001010";
    wait for PERIOD;
    sel <= "00000010";
    wait for PERIOD;
    sel <= "00000000";
    wait for PERIOD;
    sel <= "11111111";
    wait for PERIOD;
    sel <= "01100000";
    wait for PERIOD;
    sel <= "11110000";
    wait for PERIOD;
    sel <= "00001111";
    wait for PERIOD;
  end process DATA_INPUT;

end tb_arch;

