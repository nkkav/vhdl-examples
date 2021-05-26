library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gcd is
  generic (
    WIDTH : integer
  );
  port (
    clock : in std_logic;
    reset : in std_logic;
    start : in std_logic;
    a     : in std_logic_vector(WIDTH-1 downto 0);
    b     : in std_logic_vector(WIDTH-1 downto 0);
    outp  : out std_logic_vector(WIDTH-1 downto 0);
    done  : out std_logic
  );
end gcd;

architecture fsmd of gcd is
  type state_type is (s0,s1,s2,s3);
  signal state: state_type;
  signal x, y, res : std_logic_vector(WIDTH-1 downto 0);
begin

  process (clock, reset)
  begin
    done <= '0';
    if (reset = '1') then
      state <= s0;
      x <= (others => '0');
      y <= (others => '0');
      res <= (others => '0');
    elsif (rising_edge(clock)) then
      case state is
        when s0 =>
          if (start = '1') then
            x <= a;
            y <= b;
            state <= s1;
          else
            state <= s0;
          end if;
        when s1 =>
          if (unsigned(x) /= 0 and unsigned(y) /= 0) then
            state <= s2;
          else
            res <= (others => '0');
            state <= s3;
          end if;
        when s2 =>
          if (x > y) then
            x <= std_logic_vector(unsigned(x) - unsigned(y));
            state <= s2;
          elsif (x < y) then
            y <= std_logic_vector(unsigned(y) - unsigned(x));
            state <= s2;
          else
            res <= x;
            state <= s3;
          end if;
        when s3 =>
          done <= '1';
          state <= s0;
      end case;
    end if;
  end process;

  outp <= res;

end fsmd;
