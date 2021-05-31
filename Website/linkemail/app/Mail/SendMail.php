<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SendMail extends Mailable
{
    use Queueable, SerializesModels;
    public $email;
    public $username;
    public $filename;
    public $filelink;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct(string $email, string $username, string $filename, string $filelink)
    {
	   $this->username = $username;
	   $this->email = $email; 
	   $this->filename = $filename; 
	   $this->filelink = $filelink;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {

	$headers  = "From: mmkumr.ping@gmail.com\r\n";
        $headers .= "Reply-To: mmkumr.ping@gmail.com\r\n";
        $headers .= "Return-Path: mmkumr.ping@gmail.com\r\n";
        $headers .= "BCC: mmkumr.ping@gmail.com\r\n";
        return $this->to($this->email, $this->username)
                    ->bcc('hi@businessteam.in')
                    ->from("hi@businessteam.in", "BusinessTeam")
                    ->subject('Request for ' . $this->filename)
                    ->markdown('email');
    }
}
