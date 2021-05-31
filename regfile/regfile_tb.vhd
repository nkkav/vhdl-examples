library IEEE;
use IEEE.std_logic_1164.all;

entity regfile_tb is
  generic (
    NWP : integer :=  1;
    NRP : integer :=  2;
    AW  : integer :=  4;
    DW  : integer :=  8
  );
end regfile_tb;

architecture tb_arch of regfile_tb is
  component regfile
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
	end component;
  -- 
  signal clock : std_logic;
  signal reset : std_logic;
  signal en    : std_logic;
  signal we_v  : std_logic_vector(NWP-1 downto 0);
  signal waddr_v : std_logic_vector(NWP*AW-1 downto 0);
  signal raddr_v : std_logic_vector(NRP*AW-1 downto 0);
  signal input_data_v : std_logic_vector(NWP*DW-1 downto 0);
  signal ram_output_v : std_logic_vector(NRP*DW-1 downto 0);
  --
  constant CLK_PERIOD : time := 50 ns;
  --
begin

  -- Unit Under Test port map
  regfile_uut : regfile
    generic map (
      NWP => NWP,
      NRP => NRP,
      AW => AW,
      DW => DW
    )
    port map (
      clock => clock,
      reset => reset,
      en => en,
      we_v => we_v,
      waddr_v => waddr_v,
      raddr_v => raddr_v,
      input_data_v => input_data_v,
      ram_output_v => ram_output_v
    );

  CLK_GEN_PROC: process(clock)
  begin
    if (clock = 'U') then 
      clock <= '1'; 
    else 
      clock <= not clock after CLK_PERIOD/2; 
    end if;
  end process CLK_GEN_PROC;
	
  DATA_INPUT: process
  begin
    en <= '0';
    reset <= '0';
    we_v <= "0";
    waddr_v <= "0000";
    raddr_v <= "00010010";
    input_data_v <= X"DE";
    wait for CLK_PERIOD;
    en <= '1';
    reset <= '1';
    we_v <= "0";
    waddr_v <= "0000";
    raddr_v <= "00010010";
    input_data_v <= X"DE";
    wait for CLK_PERIOD;
    reset <= '0';
    we_v <= "0";
    waddr_v <= "0000";
    raddr_v <= "00010010";
    input_data_v <= X"DE";
    wait for CLK_PERIOD;
    we_v <= "1";
    waddr_v <= "0101";
    raddr_v <= "01010010";
    input_data_v <= X"DE";
    wait for CLK_PERIOD;
    we_v <= "1";
    waddr_v <= "0111";
    raddr_v <= "01010000";
    input_data_v <= X"AD";
    wait for CLK_PERIOD;
    we_v <= "1";
    waddr_v <= "1011";
    raddr_v <= "01010000";
    input_data_v <= X"BE";
    wait for CLK_PERIOD;
    we_v <= "1";
    waddr_v <= "1101";
    raddr_v <= "01010111";
    input_data_v <= X"EF";
    wait for CLK_PERIOD;
    we_v <= "0";
    waddr_v <= "1101";
    raddr_v <= "01010111";
    input_data_v <= X"55";
    wait for CLK_PERIOD;
    we_v <= "0";
    waddr_v <= "1101";
    raddr_v <= "10111101";
    input_data_v <= X"AA";
    wait for 2*CLK_PERIOD;
  end process DATA_INPUT;

end tb_arch;
