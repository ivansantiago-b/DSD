----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/06/2023 10:34:17 PM
-- Design Name: 
-- Module Name: divider_unit_control - Behavioral
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

entity divider_unit_control is
    port(
        clock, reset, go : in std_logic;
        flags : in std_logic_vector(2 downto 0);
        d_we, d_sel, d_en, i_we, y_we, result_we, b_we : out std_logic
    );
end divider_unit_control;

architecture Behavioral of divider_unit_control is
    type state_t is (start, input, test_non_zero, test_i, shift, test_borrow, update_remainder, done);
    signal current_state, next_state : state_t;
begin
state_register:
    process(clock, reset)
    begin
        if reset = '1' then
            current_state <= start;
        elsif rising_edge(clock) then
            current_state <= next_state;
        end if;
    end process state_register;

machine_input:
    process(current_state, go, flags)
    begin
        case current_state is
            when start =>
                if go = '1' then
                    next_state <= input;
                else
                    next_state <= start;
                end if;
            when input =>
                next_state <= test_non_zero;
            when test_non_zero =>
                if flags(2) = '1' then
                    next_state <= shift;
                else
                    next_state <= done;
                end if;
            when shift =>
                next_state <= test_borrow;
            when test_borrow =>
                if flags(1) = '1' then
                    next_state <= update_remainder;
                else
                    next_state <= test_i;
                end if;
            when update_remainder =>
                next_state <= test_i;
            when test_i =>
                if flags(0) = '1' then
                    next_state <= done;
                else
                    next_state <= shift;
                end if;
            when done =>
                next_state <= done;
            when others =>
                null;
        end case;
    end process machine_input;

machine_output:
    process(current_state)
    begin
        case current_state is
            when start =>
                d_sel <= '1';
                d_we <= '0';
                d_en <= '0';
                i_we <= '0';
                y_we <= '0';
                result_we <= '0';
                b_we <= '0';
            when input =>
                d_we <= '1';
                y_we <= '1';
            when test_non_zero =>
                d_we <= '0';
                y_we <= '0';
            when shift =>
                d_en <= '1';
                i_we <= '1';
            when test_borrow =>
                b_we <= '1';
                d_en <= '0';
                i_we <= '0';
            when update_remainder =>
                d_sel <= '0';
                d_we <= '1';
                b_we <= '1';
            when test_i =>
                d_we <= '0';
                b_we <= '0';
            when done =>
                result_we <= '1'; 
            when others =>
                null;
            end case;
    end process machine_output;
end Behavioral;
