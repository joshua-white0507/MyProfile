const { test, expect } = require('@playwright/test');


test.describe('User Sign-Up Page', () => {
    test('User can sign up successfully', async ({ page }) => {
        // Navigate to the sign-up page
        await page.goto('http://127.0.0.1:3000/users/sign_up');

        // Wait for the sign-up form to appear
        await page.waitForSelector('form#new_user');

        // Fill in the sign-up form
        await page.fill('input[name="user[name]"]', 'Test User');
        await page.fill('input[name="user[email]"]', 'testuser@example.com');
        await page.fill('input[name="user[password]"]', 'password');
        await page.fill('input[name="user[password_confirmation]"]', 'password');

        // Submit the form by clicking the "Create profile" button
        await page.click('input[type="submit"][value="Create profile"]');

        // Debugging: Take a screenshot after user creation
        await page.screenshot({ path: 'user_sign_up.png' });
    });
});

test.describe('User Profile Page', () => {
    test('Admin can view a user profile and see correct fields', async ({ page }) => {
        // Navigate to the login page
        await page.goto('http://localhost:3000/users/sign_in');

        // Wait for email input to appear
        await page.waitForSelector('input[name="user[email]"]');

        // Fill in the login form
        await page.fill('input[name="user[email]"]', 'testuser@example.com');
        await page.fill('input[name="user[password]"]', 'password');

        // Wait for the submit button to be visible and enabled
        await page.waitForSelector('input[type="submit"][value="Sign in"]');

        // Click the submit button
        await page.click('input[type="submit"][value="Sign in"]');

        // Debugging: Log the current URL
        console.log('Current URL after sign-in:', await page.url());

        // Debugging: Check for error messages

        // Debugging: Take a screenshot
        await page.screenshot({ path: 'debug_sign_in.png' });

        // Navigate to the users index page
        await page.goto('http://localhost:3000/users');

        // Debugging: Take a screenshot of the users page
        await page.screenshot({ path: 'users_page.png' });

        // Debugging: Check for "View Profile" buttons
        const viewProfileButtons = await page.locator('a', { hasText: 'View Profile' }).count();

        // Wait for the "View Profile" button to appear
        await page.waitForSelector('a', { hasText: 'View Profile' });

        // Click on the "View Profile" button for the first user
        await page.click('a', { hasText: 'View Profile' });

        await page.goto('http://localhost:3000/users/196');


    });
});

test.describe('Delete User Profile', () => {
    test('User can delete their profile successfully', async ({ page }) => {
        // Navigate to the login page
        await page.goto('http://localhost:3000/users/sign_in');

        // Wait for email input to appear
        await page.waitForSelector('input[name="user[email]"]');

        // Fill in the login form
        await page.fill('input[name="user[email]"]', 'testuser@example.com');
        await page.fill('input[name="user[password]"]', 'password');

        // Wait for the submit button to be visible and enabled
        await page.waitForSelector('input[type="submit"][value="Sign in"]');

        // Click the submit button
        await page.click('input[type="submit"][value="Sign in"]');

        // Debugging: Log the current URL
        console.log('Current URL after sign-in:', await page.url());

        // Navigate to the "Update Profile" page via the navigation bar
        await page.click('a[href="/users/edit"]'); // Adjust the selector if necessary

        // Wait for the "Update Profile" page to load
        await page.waitForSelector('form#edit_user');

        // Debugging: Take a screenshot of the "Update Profile" page
        await page.screenshot({ path: 'update_profile_page.png' });

        // Ensure the "Delete Profile" button is visible
        await expect(page.locator('a.btn-danger', { hasText: 'Delete my profile' })).toBeVisible();

        // Debugging: Take a screenshot before clicking the "Delete Profile" button
        await page.screenshot({ path: 'before_delete_profile.png' });

        // Handle the confirmation dialog
        page.on('dialog', async (dialog) => {
            console.log(`Dialog message: ${dialog.message()}`); // Log the dialog message
            await dialog.accept(); // Accept the confirmation dialog
        });

        // Click the "Delete Profile" button and wait for navigation
        await Promise.all([
            page.waitForNavigation(), // Wait for the navigation to complete
            page.click('a.btn-danger', { hasText: 'Delete my profile' }), // Click the button
        ]);

        // Debugging: Take a screenshot after deletion
        await page.screenshot({ path: 'user_deleted.png' });

    });
});

