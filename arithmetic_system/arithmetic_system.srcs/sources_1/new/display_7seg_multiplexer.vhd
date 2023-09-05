----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/26/2023 02:14:51 PM
-- Design Name: 
-- Module Name: display_7seg_multiplexer - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity display_7seg_multiplexer is
    port(
        clk100M : in std_logic;
        display0, display1, display2 : in std_logic_vector (6 downto 0);
        anodes : out std_logic_vector (3 downto 0);
        cathodes : out std_logic_vector (6 downto 0)
    );
end display_7seg_multiplexer;

architecture Behavioral of display_7seg_multiplexer is
    signal counter : integer range 0 to 500000;
    signal selector : std_logic_vector (1 downto 0) := "00";
begin
clk50Hz:
    process(clk100M)
    begin
        if (rising_edge(clk100M)) then
            if (counter < 500000) then
                counter <= counter + 1;
            else
                selector <= selector + 1;
                counter <= 0;
            end if;
        end if;
    end process;
    
    with selector select
        anodes <= "1011" when "01",
                  "1101" when "10",
                  "1110" when "11",
                  "1111" when others;
    with selector select
        cathodes <= display2  when "01",
                    display1  when "10",
                    display0  when "11",
                    "1111111" when others; 
end Behavioral;
