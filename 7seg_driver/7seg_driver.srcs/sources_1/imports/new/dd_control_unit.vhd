----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/22/2023 12:58:16 AM
-- Design Name: 
-- Module Name: dd_control_unit - Behavioral
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

entity dd_control_unit is
    port(
        clock, clear, go, flag : in std_logic;
        n_sel, bcd_we, we, se : out std_logic
    );
end dd_control_unit;

architecture Behavioral of dd_control_unit is
    type state_t is (start, input, shift, update, done);
    signal current_state, next_state : state_t;
begin
state_register:
    process(clock, clear)
    begin
        if clear = '1' then
            current_state <= start;
        elsif rising_edge(clock) then
            current_state <= next_state;
        end if;
    end process;
state_machine:
    process(clock, clear, go, flag, current_state)
    begin
        case current_state is
            when start =>
                if go = '1' then
                    next_state <= input;
                else
                    next_state <= start;
                end if;
                we <= '0';
                se <= '0';
                n_sel <= '0';
                bcd_we <= '0';
            when input =>
                next_state <= shift;
                n_sel <= '1';
                we <= '1';
            when shift =>
                if flag = '1' then
                    next_state <= done;
                else
                    next_state <= update;
                end if;
                n_sel <= '0';
                se <= '1';
                we <= '0';
            when update =>
                next_state <= shift;
                se <= '0';
                we <= '1';
            when done =>
                next_state <= done;
                bcd_we <= '1';
                se <= '0';
        end case;
    end process;
end Behavioral;
