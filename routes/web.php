<?php

use Illuminate\Support\Facades\Route;

use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Auth\RegisterController;
use App\Http\Controllers\Auth\ForgotPasswordController;
use App\Http\Controllers\Auth\ResetPasswordController;
use App\Http\Controllers\ProfileController;

Route::get('/', fn () => redirect()->route('login'));

/**
 * AUTH (Laravel 12 friendly - middleware đặt ở route)
 */
Route::get('/login', [LoginController::class, 'show'])->middleware('guest')->name('login');
Route::post('/login', [LoginController::class, 'login'])->middleware('guest');
Route::post('/logout', [LoginController::class, 'logout'])->middleware('auth')->name('logout');

Route::get('/register', [RegisterController::class, 'show'])->middleware('guest')->name('register');
Route::post('/register', [RegisterController::class, 'register'])->middleware('guest');

/**
 * Forgot/Reset password (giữ tên route để khớp view auth bạn copy)
 */
Route::get('/forgot-password', [ForgotPasswordController::class, 'show'])->middleware('guest')->name('forgot-password');
Route::post('/forgot-password', [ForgotPasswordController::class, 'send'])->middleware('guest')->name('forgot-password.post');

Route::get('/reset-password/{token}', [ResetPasswordController::class, 'show'])->middleware('guest')->name('password.reset');
Route::post('/reset-password', [ResetPasswordController::class, 'update'])->middleware('guest')->name('password.update');

/**
 * HOME + PROFILE
 */
Route::get('/home', fn () => 'Đăng nhập OK ✅')->middleware('auth')->name('home');

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::post('/profile', [ProfileController::class, 'update'])->name('profile.update');

    Route::get('/profile/password', [ProfileController::class, 'passwordForm'])->name('profile.password');
    Route::post('/profile/password', [ProfileController::class, 'changePassword'])->name('profile.password.update');
});

/**
 * ADMIN (chỉ admin mới vào được)
 */
Route::middleware(['auth', 'admin'])->prefix('admin')->group(function () {
    Route::get('/', fn () => 'Admin dashboard ✅');
});
