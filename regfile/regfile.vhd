library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity regfile is
  generic (
    NWP : integer :=  1;
    NRP : integer :=  2;
    AW  : integer :=  8;
    DW  : integer := 32
  );
  port (
    clock        : in  std_logic;
    reset        : in  std_logic;
    en           : in  std_logic;
    we_v         : in  std_logic_vector(NWP-1 downto 0);
    waddr_v      : in  std_logic_vector(NWP*AW-1 downto 0);
    raddr_v      : in  std_logic_vector(NRP*AW-1 downto 0);
    input_data_v : in  std_logic_vector(NWP*DW-1 downto 0);
    ram_output_v : out std_logic_vector(NRP*DW-1 downto 0)
  );
end regfile;

architecture synth of regfile is
  type mem_type is array ((2**AW-1) downto 0) of 
    std_logic_vector(DW-1 downto 0);
  signal ram_name : mem_type := (others => (others => '0'));
begin
  process (clock)
  begin
    if (rising_edge(clock)) then
      if (en = '1') then
        for i in 0 to NWP-1 loop
          if ((we_v(i) = '1')) then
            ram_name(to_integer(unsigned(waddr_v(AW*(i+1)-1 downto AW*i)))) <= 
            input_data_v(DW*(i+1)-1 downto DW*i);
          end if;
        end loop;
      end if;
    end if;
  end process;

  G_DO_NRP: for i in 0 to NRP-1 generate
   ram_output_v(DW*(i+1)-1 downto DW*i) <= 
   ram_name(to_integer(unsigned(raddr_v(AW*(i+1)-1 downto AW*i))));
  end generate;
	
end synth;
