----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/11/2023 11:28:30 PM
-- Design Name: 
-- Module Name: system_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity system_tb is
--  Port ( );
end system_tb;

architecture Behavioral of system_tb is
    signal master_clock, reset, pass, fail: std_logic;
    signal secret_code : std_logic_vector(7 downto 0);
    signal buttons : std_logic_vector(2 downto 0);
begin
dut:
    entity work.system port map(master_clock => master_clock, reset => reset, secret_code => secret_code, buttons => buttons, pass => pass, fail => fail);
stimulus:
    secret_code <= "01100100";
    process
    begin
        master_clock <= '0';
        wait for 5 ns;
        master_clock <= '1';
        wait for 5 ns;
    end process;
    
    process
    begin
    -- Sequence: 0 1 2 1
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        buttons <= "001";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "010";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "100";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "010";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
    -- Sequence: 1 1 2 1
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        buttons <= "010";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "010";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "100";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "010";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
    -- Sequence: 0 2 2 1
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        buttons <= "001";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "100";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "100";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "010";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
    -- Sequence: 0 1 0 1
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        buttons <= "001";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "010";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "001";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "010";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
    -- Sequence: 0 1 2 2
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
        buttons <= "001";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "010";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "100";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
        buttons <= "100";
        wait for 36 ms;
        buttons <= "000";
        wait for 6 ms;
    end process;
end Behavioral;
