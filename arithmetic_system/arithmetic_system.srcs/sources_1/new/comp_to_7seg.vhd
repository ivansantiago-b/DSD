----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/26/2023 02:14:21 PM
-- Design Name: 
-- Module Name: comp_to_7seg - Behavioral
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

entity comp_to_7seg is
    port(
        m : in std_logic_vector (2 downto 0);        -- L E G
        segments : out std_logic_vector (6 downto 0) -- G F E D C B A
    );
end comp_to_7seg;

architecture Behavioral of comp_to_7seg is

begin
    with m select
    segments <= "1000111" when "100",
                "0000110" when "010",
                "0000010" when "001",
                "1111111" when others;
end Behavioral;
