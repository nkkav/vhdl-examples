library IEEE, STD;
use STD.textio.all;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gcd_tb is
  generic (
    WIDTH : integer := 8
  );
end gcd_tb;

architecture tb_arch of gcd_tb is
  -- Component declarations
  component gcd
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
  end component;
  -- Signal declarations
  -- Stimulus signals
  signal clock, reset, start : std_logic;
  signal a, b : std_logic_vector(WIDTH-1 downto 0);
  -- Observed signals
  signal outp : std_logic_vector(WIDTH-1 downto 0);
  signal done : std_logic;
  -- Profiling signals
  signal ncycles : integer;
  -- Constant declarations
  constant CLK_PERIOD : time := 10 ns;
  -------------------------------------------------------
  -- Declare test data file and results file
  -------------------------------------------------------
  file TestDataFile: text open read_mode is "gcd_test_data.txt";
  file ResultsFile: text open write_mode is "gcd_alg_test_results.txt";
begin

  uut : gcd
    generic map (
      WIDTH => WIDTH
    )
    port map (
      clock => clock,
      reset => reset,
      start => start,
      a => a,
      b => b,
      outp => outp,
      done => done
  );

  CLK_GEN_PROC: process(clock)
  begin
    if (clock = 'U') then
      clock <= '1';
    else
      clock <= not clock after CLK_PERIOD/2;
    end if;
  end process CLK_GEN_PROC;

  RESET_START_STIM: process
  begin
    reset <= '1';
    start <= '1';
    wait for CLK_PERIOD;
    reset <= '0';
    wait for 120*CLK_PERIOD;
  end process RESET_START_STIM;

  PROFILING: process(clock, reset, done)
  begin
    if (reset = '1' or done = '1') then
      ncycles <= 0;
    elsif (rising_edge(clock)) then
      ncycles <= ncycles + 1;
    end if;
   end process PROFILING;

  GCD_EMUL: process
    variable A_v,B_v,Y_v,Y_Ref,temp: integer range 0 to 255;
    variable ncycles_v: integer;
    variable TestData: line;
    variable BufLine: line;
    variable Passed: std_logic := '1';
  begin
    while not endfile(TestDataFile) loop
      -----------------------------------------
      ---- Read test data from file
      -----------------------------------------
      readline(TestDataFile, TestData);
      read(TestData, A_v);
      read(TestData, B_v);
      read(TestData, temp); -- reading the 3rd value (unused here)
      a <= std_logic_vector(to_unsigned(A_v, WIDTH));
      b <= std_logic_vector(to_unsigned(B_v, WIDTH));
      --------------------------------------
      ---- Model GCD algorithm
      --------------------------------------
      if (A_v /= 0 and B_v /= 0) then
        while (A_v /= B_v) loop
          if (A_v >= B_v) then
            A_v := A_v - B_v;
          else
            B_v := B_v - A_v;
          end if;
        end loop;
      else
        A_v := 0;
      end if;
      Y_Ref := A_v;
      --
      wait until done = '1';
      --
      Y_v := to_integer(unsigned(outp));
      -----------------------------------
      ---- Test GCD algorithm
      -----------------------------------
      if (Y_v /= Y_Ref) then -- has failed
        Passed := '0';
        write(Bufline, string'("GCD Error: A="));
        write(Bufline, A_v);
        write(Bufline, string'(" B="));
        write(Bufline, B_v);
        write(Bufline, string'(" Y="));
        write(Bufline, Y_v);
        write(Bufline, string'(" Y_Ref="));
        write(Bufline, Y_Ref);
        writeline(ResultsFile, Bufline);
      else
        ncycles_v := ncycles;
        write(Bufline, string'("GCD OK: Number of cycles="));
        write(Bufline, ncycles_v);
        writeline(ResultsFile, Bufline);
      end if;
    end loop;
    if (Passed = '1') then -- has passed
      write(Bufline, string'("GCD algorithm test has passed"));
      writeline(ResultsFile, Bufline);
    end if;
    wait for CLK_PERIOD;
  end process GCD_EMUL;

end tb_arch;
