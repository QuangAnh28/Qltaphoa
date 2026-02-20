<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use HasFactory, Notifiable;

    protected $fillable = [
        'name',
        'email',
        'password',
        'role', // admin | user
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    public function setPasswordAttribute($value): void
    {
        // tránh hash lại nếu đã bcrypt
        if (is_string($value) && str_starts_with($value, '$2y$')) {
            $this->attributes['password'] = $value;
            return;
        }
        $this->attributes['password'] = bcrypt($value);
    }

    public function isAdmin(): bool
    {
        return $this->role === 'admin';
    }
}
