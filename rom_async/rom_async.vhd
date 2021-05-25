library ieee;
use ieee.std_logic_1164.all;

entity rom_async is
  port (
    addr : in std_logic_vector(3 downto 0);
    data : out std_logic_vector(7 downto 0)
  );
end rom_async;

architecture impl of rom_async is
begin
  process (addr)
  begin
    case addr is
      when "0000" => data <= X"01";
      when "0001" => data <= X"02";
      when "0010" => data <= X"04";
      when "0011" => data <= X"08";
      when "0100" => data <= X"10";
      when "0101" => data <= X"20";
      when "0110" => data <= X"40";
      when "0111" => data <= X"80";
      when "1000" => data <= X"01";
      when "1001" => data <= X"03";
      when "1010" => data <= X"07";
      when "1011" => data <= X"0F";
      when "1100" => data <= X"1F";
      when "1101" => data <= X"3F";
      when "1110" => data <= X"7F";
      when "1111" => data <= X"FF";
      when others => data <= X"00";
    end case;
  end process;
end impl;
