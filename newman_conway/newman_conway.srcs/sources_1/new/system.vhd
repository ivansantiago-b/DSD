----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/03/2023 02:32:40 PM
-- Design Name: 
-- Module Name: system - Behavioral
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

entity system is
    port(
        master_clock, reset, button: in std_logic;
        n : in std_logic_vector(7 downto 0)
    );
end system;

architecture Behavioral of system is
    signal comp_n, comp_i, ram_we, i_we, n_we, x_we, y_we, t_we : std_logic;
    signal y_selector, i_selector, r_selector : std_logic;
    signal a, t : std_logic_vector(7 downto 0);
    signal r : std_logic_vector(6 downto 0);
    signal a_selector : std_logic_vector(2 downto 0);
begin
U0:
    entity work.data_path port map(a_selector => a_selector, a => a, clock => master_clock, reset => reset, i_selector => i_selector, y_selector => y_selector, r_selector => r_selector, ram_we => ram_we, n_we => n_we, x_we => x_we, y_we => y_we, i_we => i_we, t_we => t_we, n_in => n, r_in => r, n_comp => comp_n, i_comp => comp_i, t => t);
U1:
    entity work.control_unit port map(clock => master_clock, reset => reset, go => button, comp_n => comp_n, comp_i => comp_i, ram_we => ram_we, n_we => n_we, x_we => x_we, y_we => y_we, i_we => i_we, t_we => t_we, a => a, a_selector => a_selector, i_selector => i_selector, y_selector => y_selector, r_selector => r_selector, r => r);
    
end Behavioral;
