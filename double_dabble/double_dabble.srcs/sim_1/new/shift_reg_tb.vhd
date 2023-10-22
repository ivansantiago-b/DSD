----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/21/2023 11:59:06 PM
-- Design Name: 
-- Module Name: shift_reg_tb - Behavioral
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

entity shift_reg_tb is
--  Port ( );
end shift_reg_tb;

architecture Behavioral of shift_reg_tb is
    signal clock, clear, we, se, c_out, c_in : std_logic;
    signal data_in, data_out : std_logic_vector(7 downto 0);
begin
dut:
    entity work.shift_reg port map(clock => clock, clear => clear, we => we, se => se, c_in => c_in, data_in => data_in, c_out => c_out, data_out => data_out);
stimulus:
    process
    begin
        clock <= '0';
        wait for 5 ns;
        clock <= '1';
        wait for 5 ns;
    end process;
    
    process
    begin
        clear <= '1';
        c_in <= '0';
        wait for 10 ns;
        clear <= '0';
        data_in <= x"FF";
        we <= '1';
        wait for 10 ns;
        we <= '0';
        se <= '1';
        wait for 10 ns;
        c_in <= '1';
        wait for 20 ns;
        c_in <= '0';
        wait;    
    end process;
end Behavioral;
