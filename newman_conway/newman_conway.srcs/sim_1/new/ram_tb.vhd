----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/01/2023 11:35:02 PM
-- Design Name: 
-- Module Name: ram_tb - Behavioral
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

entity ram_tb is
--  Port ( );
end ram_tb;

architecture Behavioral of ram_tb is
    signal write_address, read_address : std_logic_vector(7 downto 0);
    signal data_in, data_out : std_logic_vector(6 downto 0);
    signal we: std_logic;
    signal clock : std_logic := '0';
begin
dut:
    entity work.ram port map(clock => clock, we => we, write_address => write_address, read_address => read_address, data_in => data_in, data_out => data_out);
stimulus:
    process
    begin
    read_address <= x"00";
    write_address <= x"00";
    data_in <= "1010101";
    we <= '1';
    wait for 10 ns;
    we <= '0';
    wait for 10 ns;
    
    write_address <= x"01";
    data_in <= "0001111";
    we <= '1';
    wait for 10 ns;
    we <= '0';
    wait for 10 ns;
    
    read_address <= x"01";
    write_address <= x"FF";
    data_in <= "0011001";
    we <= '1';
    wait for 10 ns;
    we <= '0';
    wait for 10 ns;
    read_address <= x"FF";
    wait;
    end process;
    
    clock <= not clock after 5 ns;
end Behavioral;
